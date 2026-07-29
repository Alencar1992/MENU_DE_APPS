alter table public.menu_apps
  add column description text not null default '',
  add column category text not null default 'Outros',
  add column icon_url text;

alter table public.menu_apps
  add constraint menu_apps_description_length_check
    check (char_length(description) <= 180),
  add constraint menu_apps_category_length_check
    check (char_length(btrim(category)) between 1 and 40),
  add constraint menu_apps_icon_url_https_check
    check (icon_url is null or icon_url ~ '^https://');

update public.menu_apps
set
  category = case name
    when 'PDV - TAPIMOVEL' then 'Tapiocaria'
    when 'ALENCAR FINANÇAS' then 'Financeiro'
    when 'ALENCAR FRETES' then 'Entregas'
    when 'CALCULADORA FRETES' then 'Entregas'
    when 'GESTÃO DE ENTREGAS' then 'Entregas'
    when 'PRIPEL GESTÃO' then 'Trabalho'
    when 'GESTÃO FINANÇAS CASA' then 'Financeiro'
    when 'TAREFAS PRI' then 'Trabalho'
    when 'MIKAA NAILS' then 'Negócios'
    when 'CARDÁPIO CLIENTE' then 'Tapiocaria'
    when 'gemini AI' then 'Ferramentas'
    when 'HUB FINANCE' then 'Financeiro'
    when 'TAPIMOVEL 2.0' then 'Tapiocaria'
    when 'CARDAPIO TAPIOCA CLIENTE' then 'Tapiocaria'
    else 'Outros'
  end,
  description = case name
    when 'PDV - TAPIMOVEL' then 'Operação de vendas e pedidos da tapiocaria.'
    when 'ALENCAR FINANÇAS' then 'Controle financeiro pessoal de forma simples.'
    when 'ALENCAR FRETES' then 'Gestão rápida de fretes e entregas.'
    when 'CALCULADORA FRETES' then 'Calcule valores e organize seus fretes.'
    when 'GESTÃO DE ENTREGAS' then 'Acompanhe entregas e organize a operação.'
    when 'PRIPEL GESTÃO' then 'Gestão administrativa da Pripel em um só lugar.'
    when 'GESTÃO FINANÇAS CASA' then 'Organize as finanças e despesas da casa.'
    when 'TAREFAS PRI' then 'Controle de tarefas e rotinas da Pripel.'
    when 'MIKAA NAILS' then 'Administração e atendimento da Mikaa Nails.'
    when 'CARDÁPIO CLIENTE' then 'Cardápio digital para pedidos dos clientes.'
    when 'gemini AI' then 'Acesso rápido ao assistente de IA do Google.'
    when 'HUB FINANCE' then 'Central de ferramentas e visão financeira.'
    when 'TAPIMOVEL 2.0' then 'Nova versão da operação TapiMóvel.'
    when 'CARDAPIO TAPIOCA CLIENTE' then 'Cardápio da TapiMóvel para clientes.'
    else 'Acesso rápido ao aplicativo.'
  end;
