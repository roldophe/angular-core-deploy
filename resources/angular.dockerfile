# Stage 1: Build the Angular application
FROM node:18-alpine as app

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first to leverage Docker cache
COPY package*.json ./

# Install dependencies using --legacy-peer-deps to handle peer dependency issues
RUN npm install --legacy-peer-deps

# Copy the rest of the application source code
COPY . .

# Build the Angular application
RUN npm run build

# Stage 2: Serve the Angular application with Nginx
FROM nginx:alpine

# Copy the build output from the first stage to Nginx
COPY --from=app /usr/src/app/dist/core-admin /usr/share/nginx/html

# List copied files for verification (optional)
RUN ls /usr/share/nginx/html

# Optional: Uncomment the line below if you have a custom nginx configuration
# COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
