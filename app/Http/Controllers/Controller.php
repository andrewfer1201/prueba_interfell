<?php

namespace App\Http\Controllers;
use App\Clientes;
use App\Billetera;
use App\Confirmacion;
use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;

class Controller extends BaseController
{

   #Funcion para registrar cliente	
   public function registrar_cliente(Request $request){

       try {

       		#Se pasan los datos desde la front "Registro Cliente"
		      $cliente = new Clientes();
		      $cliente->documento = $request->documento;
		      $cliente->nombre = $request->nombre;
		      $cliente->celular = $request->celular;
		      $cliente->email = $request->email;
		      $cliente->save();

		      return response()->json(['mensaje' => 'Cliente registrado', 'codigo' => 200]);

    	} catch(\Illuminate\Database\QueryException $ex){ #captura los errores de la BD

       	 	 return response()->json(['mensaje' => 'Hay algun error al guardar los datos', 'codigo' => 500]);
    	}

    }

  #Funcion para recargar cuenta cliente
   public function recargar(Request $request){

   	   try {

       		#Se pasan los datos desde la front "Recarga"
		      $billetera = Billetera::where('celular',$request->celular)->where('documento',$request->documento)->first();



		     if ($billetera == null) {

				      $billetera = new Billetera();
				      $billetera->documento = $request->documento;
				      $billetera->celular = $request->celular;
				      $billetera->cantidad_disponible = $request->cantidad;
				      $billetera->save();

				}else{

						$billetera->documento = $request->documento;
					    $billetera->celular = $request->celular;
					    $billetera->cantidad_disponible =  $billetera->cantidad_disponible+ $request->cantidad;
					    $billetera->save();
					  

				}


		      return response()->json(['mensaje' => '!Recarga Exitosa!']);

    	} catch(\Illuminate\Database\QueryException $ex){ #captura los errores de la BD

       	 	 return response()->json(['mensaje' => 'No se completo la recarga, Por favor vuelva a intentarlo']);
    	}

   }


   #Funcion para consultar el saldo
   public function consulta(Request $request){

   	   try {

     
	   	  $saldo = Billetera::where('documento',$request->documento)->where('celular',$request->celular)->get();



	      return response()->json(['saldo' => $saldo]);

    	} catch(\Illuminate\Database\QueryException $ex){ #captura los errores de la BD

       	 	 return response()->json(['mensaje' => 'No se completo la consulta, Por favor vuelva a intentarlo']);
    	}

   }


	#Funcion para crear token de seguridad y procesar la solicitud de compra
    public function solicitud_pago(Request $request){

   	   try {

     
	   	 $saldo = Billetera::where('documento',$request->documento)->where('celular',$request->celular)->get();
	   	 $email = Clientes::where('documento',$request->documento)->where('celular',$request->celular)->get();

	   	 if ($saldo[0]->cantidad_disponible > 0){
	   	 	$token = rand(100000,999999); #se genera el token de confirmacion

	   	 	#se procede al guardado del token y el id de sesion para la confirmacion

 			 $confirmacion = new Confirmacion();
	   	 	 $confirmacion->id_sesion = $request->id_sesion;
	   	 	 $confirmacion->token = $token;
	   	 	 $confirmacion->save();

	   	 	return response()->json(['token' => $token, 'email' => $email[0]->email, 'error' => true]);

	   	 }else{
	   	 	return response()->json(['mensaje' => 'Saldo insuficiente para realizar esta compra','error' => false]);
	   	 }
	


    	} catch(\Illuminate\Database\QueryException $ex){ #captura los errores de la BD

       	 	 return response()->json(['mensaje' => 'No se completo la recarga, Por favor vuelva a intentarlo']);
    	}

   }

 	#Funcion para confirmar el pago mediante el token y el id_sesion
   public function confirmar_pago(Request $request){

   	   try {

       		#Se hace la consulta para verificar si existe el token y el id_sesion
		     $verificar = Confirmacion::where('id_sesion',$request->id_sesion)->where('token',$request->token)->get();


		     if(count($verificar)!== 0){ // se verifica si en la consulta anterior hay datos

		     	$billetera = Billetera::where('celular',$request->celular)->where('documento',$request->documento)->first();

		     	$billetera->cantidad_disponible = $billetera->cantidad_disponible - $request->cantidad_compra;
		     	$billetera->save();
		     	
		     	return response()->json(['mensaje' => '!Compra realizada con exito!']);
		     }else{
		     	return response()->json(['mensaje' => '!Algunos datos son incorrecto, vuelva a intentarlo!']);
		     }

    	} catch(\Illuminate\Database\QueryException $ex){ #captura los errores de la BD

       	 	 return response()->json(['mensaje' => 'No se completo la consulta, Por favor vuelva a intentarlo']);
    	}

   }



}
