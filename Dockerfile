# Use nginx as the web server (lightweight and reliable)
FROM nginx:alpine

# Copy our HTML file to where nginx looks for files
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 (the web server port)
EXPOSE 80
