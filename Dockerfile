#specify the phase with as keyword
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#by putting in another FROM statement it tells docker that the previous work is done (the builder step)
FROM nginx
EXPOSE 80
#copy over something from the builder phase
COPY --from=builder /app/build /usr/share/nginx/html
