package main

import (
	"api/common/web"
	"api/config"
	"api/logs"
	"fmt"
	"go.uber.org/zap"

	_ "api/controller/pub"
	_ "api/controller/user"
	_ "api/role"
	"net/http"
	"os"
	"os/signal"
	"syscall"
)

// @securityDefinitions.apikey Jwt
// @in header
// @name Authorization
func main() {
	server := &http.Server{
		Addr:    fmt.Sprintf("%s:%s", config.Evn.Host, config.Evn.Port),
		Handler: web.Engine,
	}

	go func() {
		logs.Log.Info("server start docs url http://localhost:8080/swagger/index.html")
		if err := server.ListenAndServe(); err != nil {
			panic(err.Error())
		}
	}()

	signals := make(chan os.Signal, 1)
	signal.Notify(signals, syscall.SIGINT, syscall.SIGTERM)
	select {
	case <-signals:
		if err := zap.L().Sync(); err != nil {
			logs.Log.Error("sync zap log error", zap.Error(err))
		}
		if err := server.Close(); err != nil {
			logs.Log.Error("close server error", zap.Error(err))
		}
		logs.Log.Info("server shutdown")
	}

}

func ApiInfoInit() {
	getwd, _ := os.Getwd()
	logs.Log.Info(getwd)
}
