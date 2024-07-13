# Stage 1: Build the Angular application
FROM node:18-alpine as app

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies using --legacy-peer-deps to handle peer dependency issues and build the Angular application
RUN npm install --legacy-peer-deps && npm run build

# Copy the rest of your application code
COPY . .

# Stage 2: Serve the Angular application with Nginx
FROM nginx:alpine

COPY --from=app /usr/src/app/dist/core-admin /usr/share/nginx/html

RUN ls /usr/share/nginx/html

# Optional: Uncomment the line below if you have a custom nginx configuration
# COPY ./nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# Start Nginx server
# CMD ["nginx", "-g", "daemon off;"]



# Use an official node image as a parent image
# FROM node:18-alpine as app

# # Set the working directory
# WORKDIR /usr/src/app

# # Copy package.json and package-lock.json
# COPY package*.json ./

# # Install dependencies
# RUN npm install --legacy-peer-deps

# # Copy the rest of your application code
# COPY . .

# # Build the application
# RUN npm run build

# # Expose the port the app runs on
# EXPOSE 4200

# # Run the application
# CMD ["npm", "start"]
