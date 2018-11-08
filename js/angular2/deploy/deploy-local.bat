set base_href=app
set env=prod

ng build --prod --aot=false --build-optimizer=false --base-href /%base_href%/ --deploy-url=/%base_href%/
REM ng build --prod --aot=false --build-optimizer=false
