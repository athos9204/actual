# ===== Builder Stage =====
FROM node:18-slim AS builder

# 1. Enable Corepack and prepare Yarn
RUN corepack enable && corepack prepare yarn@4.3.1 --activate

# Force Yarn to use the node-modules linker
ENV YARN_NODE_LINKER=node-modules

WORKDIR /app

# 2. Copy Yarn configuration and infrastructure
COPY .yarnrc.yml .yarn/releases/yarn-4.3.1.cjs .yarn/

# 3. Copy root manifests
COPY package.json yarn.lock ./

# 4. Copy the entire workspace directories
COPY packages ./packages

# 5. (Optional) Validate workspace structure
RUN find packages/ -name package.json | xargs -I{} sh -c 'echo "Workspace manifest: {}"'

# 6. Install production dependencies for the sync-server workspace
RUN yarn workspaces focus @actual-app/sync-server --production

# 7. Copy remaining source code (if there are additional files outside the above directories)
COPY . .

# ===== Production Stage =====
FROM node:18-slim AS production

WORKDIR /app

# Force Yarn to use node-modules in production as well
ENV YARN_NODE_LINKER=node-modules

# Copy the built application from the builder stage.
COPY --from=builder /app /app

# Create a non-root user with a proper home directory and adjust permissions.
RUN addgroup --system app && \
    adduser --system --ingroup app --home /home/app app && \
    chown -R app:app /app /home/app

# Switch to the non-root user.
USER app
ENV HOME=/home/app

# Expose the server port.
EXPOSE 5006

# Start the Actual server.
CMD ["yarn", "start:server"]
