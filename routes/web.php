<?php

/** 
Rutas
*/

$router->get('/', function () use ($router) {
    return $router->app->version();
});


$router->get('/registrar_cliente', 'Controller@registrar_cliente'); //Registra cliente

$router->get('/recargar', 'Controller@recargar'); //Recarga billetera

$router->get('/consulta', 'Controller@consulta'); //Consulta de saldo

$router->get('/solicitud_pago', 'Controller@solicitud_pago'); //solicita el pago al sistema

$router->get('/confirmacion_pago', 'Controller@confirmar_pago'); //se confimar el pago y si todo va bien se descuenta el saldo