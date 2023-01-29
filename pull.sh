cd /app
git pull origin production
rm -r /usr/share/nginx/html/*
cp -r ./public/* /usr/share/nginx/html