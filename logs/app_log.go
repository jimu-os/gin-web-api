package logs

import (
	"api/common/logger"
	"api/config"
)

var Log *logger.AppLog

func init() {
	Log = logger.NewAppLog(
		logger.FilePath(config.Evn.Logger.Path),
		logger.FileName(config.Evn.Logger.FileName),
		logger.MaxSize(config.Evn.Logger.MaxSize),
		logger.MaxBackups(config.Evn.Logger.MaxBackups),
		logger.MaxAge(config.Evn.Logger.MaxAge),
		logger.Level(config.Evn.Logger.Level),
	)
}
