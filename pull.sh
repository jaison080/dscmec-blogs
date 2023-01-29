cd /app
git fetch
git reset --hard origin/production
rm -r /usr/share/nginx/html/*
cp -r ./public/* /usr/share/nginx/html
