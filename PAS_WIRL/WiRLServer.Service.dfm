object LazyDocumentsWiRLService: TLazyDocumentsWiRLService
  OldCreateOrder = False
  OnCreate = ServiceCreate
  OnDestroy = ServiceDestroy
  DisplayName = 'LazyDocuments WiRL Service'
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
  Height = 150
  Width = 215
end
