<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\ConfirmPayment;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class ConfirmPaymentController extends Controller
{
    public function index(){
        $confirmPayments = ConfirmPayment::with('order','user')->get();
        
        if(count($confirmPayments) > 0){
            return response([
                'message' => 'Retrive All Success',
                'data' => $confirmPayments
            ],200);
        }

        return response([
            'message' => 'Empty',
            'data' => null
        ],404);
    }

    public function show($id){
        $confirmPayment = ConfirmPayment::find($id);

        if(!is_null($confirmPayment)){
            return response([
                'message' => 'Retrive Data Success',
                'data' => $confirmPayment
            ],200);
        }

        return response([
            'message' => 'Empty',
            'data' => null
        ],404);
    }

    public function store(Request $request){
        $storeData =  $request->all();
        $validate =  Validator::make($storeData,[
            'order_id' => 'required',
            'image' => 'required|mimes:jpeg,jpg,png,gif',
        ]);
        
        if($validate->fails())
            return response(['message' => $validate->errors(),400]);
        
        $timeStmp = Carbon::now()->localeMonth.Carbon::now()->year;
        $path = "confirm-payments/".$timeStmp."/";
        $img = $request->file('image')
            ->move(public_path()."/storage/".$path,$request->file('image')->getClientOriginalName());
        
        $img_name = $path.$request->file('image')->getClientOriginalName();
        
        $storeData['image'] = $img_name;
        
        $storeData['user_id'] = Auth::user()->id;
        $store['status']= "menunggu konfirmasi";

        $confirmPayment = ConfirmPayment::create($storeData);
        return response([
            'message' => 'Add confirmPayment Success',
            'data' => $confirmPayment
        ],200);

    }

    public function destroy($id){
        $confirmPayment = ConfirmPayment::find($id);
        if(is_null($confirmPayment)){
            return response([
                'message' => 'confirmPayment Not Found',
                'data' => null
            ],404);
        }

        if($confirmPayment->delete()){
            return response([
                'message' => 'Delete confirmPayment Success',
                'data' => $confirmPayment
            ],200);
        }

        return response([
            'message' => 'Delete confirmPayment Failed',
            'data' => null
        ],400);
        
    }

    public function update(Request $request , $id){
        $confirmPayment = ConfirmPayment::find($id);
        if(is_null($confirmPayment)){
            return response([
                'message' => 'confirmPayment Not Found',
                'data' => null
            ],404);
        }
        $updateData =  $request->all();
        $validate =  Validator::make($updateData,[
            'status' => 'required',
        ]);

        if($validate->fails())
            return response(['message' => $validate->errors(),400]);
        
        $confirmPayment->status = $updateData['status'];

        if($confirmPayment->save()){
            return response([
                'message' => 'Update confirmPayment Success',
                'data' => $confirmPayment
            ],200);
        }

        return response([
            'message' => 'Update confirmPayment Failed',
            'data' => null
        ],400);
    }
}
