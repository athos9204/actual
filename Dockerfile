# Use a smaller Node.js image (slim version)
FROM node:18-slim

# Enable Corepack and install Yarn 4.3.1
RUN corepack enable && corepack prepare yarn@4.3.1 --activate

# Set the working directory in the container
WORKDIR /app

# Copy package.json and yarn.lock files into the container (only those files needed to install dependencies)
COPY package.json yarn.lock ./

# Install project dependencies using Yarn workspaces focus for production
RUN yarn workspaces focus --production

# Copy the rest of the project files into the container (only after dependencies are installed)
COPY . .

# Switch to a non-root user for security
RUN addgroup --system app && adduser --system --ingroup app app && chown -R app:app /app
USER app

# Expose port 5006 for Actual server
EXPOSE 5006

# Start the Actual server
CMD ["yarn", "start:server"]
