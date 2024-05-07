# -------------------------------- Stage 1: Build Stage -------------------------------
FROM node:12.2.0-alpine AS build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run test

# ------------------------------- Stage 2: Production Stage ----------------------------
FROM node:12.2.0-alpine AS prod
WORKDIR /app
COPY --from=build /app .
EXPOSE 8000
CMD ["npm", "start"]

