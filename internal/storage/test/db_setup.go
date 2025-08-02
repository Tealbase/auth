package test

import (
	"github.com/tealbase/gotrue/internal/conf"
	"github.com/tealbase/gotrue/internal/storage"
)

func SetupDBConnection(globalConfig *conf.GlobalConfiguration) (*storage.Connection, error) {
	return storage.Dial(globalConfig)
}
