package user

import (
	"api/common/auth"
	"api/common/web"
	"api/config"
)

func init() {
	api := web.Engine.Group("/api/user", auth.Authorization(config.Evn.Auth.AccessSecret))
	api.GET("/info", Info)
}
