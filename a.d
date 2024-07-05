            useEffect = (()=>{setData(JSON.stringify(data.data,null,'\t'))},[data])
    if (!Informacion.length == 0) {
        setAppStatus(APP_STATUS.READY_SUBMIT_BD)
    }

    APP_STATUS.UPLOADING || appStatus == APP_STATUS.IDLE || appStatus == APP_STATUS.ERROR || appStatus == APP_STATUS.READY_UPLOAD || appStatus == APP_STATUS.READY_USAGE