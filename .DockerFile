# Use the official Node.js image as base
FROM node:16

# Set the working directory inside the container for backend
WORKDIR /usr/src/backend

# Copy package.json and package-lock.json for backend
COPY package*.json ./

# Install backend dependencies
RUN npm install

# Install TypeScript globally
RUN npm install -g typescript

# Copy the rest of the backend application code
COPY . .

# Build the backend (if applicable)
RUN npm run build

# Expose the port your backend app runs on
EXPOSE 3000

# Command to run the backend application
CMD ["npm", "start"]

# Use a separate stage for the frontend
FROM node:16 AS frontend

# Set the working directory inside the container for frontend
WORKDIR /usr/src/frontend

# Copy package.json and package-lock.json for frontend
COPY client/package*.json ./

# Install frontend dependencies
RUN npm install

# Copy the rest of the frontend application code
COPY client ./

# Build the frontend
RUN npm run build

# Expose the port your frontend app runs on
EXPOSE 5173

# Command to run the frontend application
CMD ["npm", "start"]
