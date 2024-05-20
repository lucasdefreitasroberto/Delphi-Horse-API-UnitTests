object ProviderConnection: TProviderConnection
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 195
  Width = 188
  object con: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=G:\Arquivos\Teste Unitario Delphi-Horse\dados\DADOS.FDB'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 16
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files (x86)\Firebird\Firebird_2_5\bin\fbclient.dll'
    Left = 48
    Top = 72
  end
  object FDQuery: TFDQuery
    Connection = con
    Transaction = FDTransaction
    Left = 48
    Top = 118
  end
  object FDTransaction: TFDTransaction
    Connection = con
    Left = 88
    Top = 14
  end
end
