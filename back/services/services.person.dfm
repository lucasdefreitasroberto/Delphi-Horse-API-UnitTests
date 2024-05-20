inherited ServicesPerson: TServicesPerson
  OldCreateOrder = True
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      'select'
      '    P.ID,'
      '    P.NOME,'
      '    P.SEXO,'
      '    P.TIPO,'
      '    P.CPFCNPJ,'
      '    P.BAIRRO,'
      '    P.ESTADO,'
      '    P.CIDADE,'
      '    P.COMPLEMENTO'
      'from PESSOA P')
  end
end
