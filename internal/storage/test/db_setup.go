package test

import (
	"github.com/tealbase/auth/internal/conf"
	"github.com/tealbase/auth/internal/storage"
)

func SetupDBConnection(globalConfig *conf.GlobalConfiguration) (*storage.Connection, error) {
	return storage.Dial(globalConfig)
}
