#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2020-2024 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="a06"
#set -o xtrace

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then

    export TW_DEFAULT_LANGUAGE="es"
    export ALLOW_MISSING_DEPENDENCIES=true
    export LC_ALL="C"

    # Datos del compilador y versión actualizados para R12.1+
    export OF_MAINTAINER="Cat"
    export FOX_BUILD_TYPE="Unofficial"
    export FOX_MAINTAINER_PATCH_VERSION=1 # <-- ¡Corregido! Solo el número 1

    # Ajustes Visuales para la nueva UI (Notch y bordes)
    export OF_HIDE_NOTCH=1
    export OF_CLOCK_POS=1
    export OF_STATUS_H=80
    export OF_STATUS_INDENT_LEFT=48
    export OF_STATUS_INDENT_RIGHT=48

    # Funciones esenciales de OrangeFox
    export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
    export OF_USE_SYSTEM_FINGERPRINT=1
    export OF_ALLOW_DISABLE_NAVBAR=0

    # Herramientas y binarios adicionales
    export FOX_USE_NANO_EDITOR=1
    export FOX_DELETE_MAGISK_ADDON=1
    export FOX_ENABLE_APP_MANAGER=1
    export FOX_USE_BASH_SHELL=1
    export FOX_ASH_IS_BASH=1
    export FOX_USE_TAR_BINARY=1
    export FOX_USE_SED_BINARY=1
    export FOX_USE_XZ_UTILS=1
    export FOX_USE_ZSTD_BINARY=1 # <-- Soporte para ROMs modernas

    # Ocultar funciones rotas de Samsung (Descomenta quitando el # si las necesitas ocultar)
    # export OF_FLASHLIGHT_ENABLE=0
    # export OF_HIDE_CPU_TEMPERATURE=1

    # let's see what are our build VARs
    if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
      export | grep "FOX" >> $FOX_BUILD_LOG_FILE
      export | grep "OF_" >> $FOX_BUILD_LOG_FILE
      export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
      export | grep "TW_" >> $FOX_BUILD_LOG_FILE
    fi
fi
