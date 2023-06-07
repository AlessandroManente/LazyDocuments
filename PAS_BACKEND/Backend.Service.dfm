object LazyDocumentsBackendService: TLazyDocumentsBackendService
  OnCreate = ServiceCreate
  OnDestroy = ServiceDestroy
  DisplayName = 'LazyDocuments Backend Service'
  BeforeInstall = ServiceBeforeInstall
  AfterInstall = ServiceAfterInstall
  BeforeUninstall = ServiceBeforeUninstall
  AfterUninstall = ServiceAfterUninstall
  OnContinue = ServiceContinue
  OnExecute = ServiceExecute
  OnPause = ServicePause
  OnShutdown = ServiceShutdown
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 300
  Width = 430
  PixelsPerInch = 192
end
