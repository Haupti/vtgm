FROM alpine:latest 
RUN apk add --no-cache libc6-compat

RUN mkdir /app
RUN mkdir -p /app /app/data
COPY main /app/main
COPY data/* /app/data/

WORKDIR /app

EXPOSE 8080
ENTRYPOINT ["./main"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]