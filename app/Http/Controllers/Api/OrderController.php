<?php

namespace App\Http\Controllers\Api;

use App\Cart;
use App\Http\Controllers\Controller;
use App\Order;
use App\OrderDetail;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class OrderController extends Controller
{
    public function index(){
        $orders = Order::where('user_id',Auth::user()->id)->get();
        
        if(count($orders) > 0){
            return response([
                'message' => 'Retrive All Success',
                'data' => $orders
            ],200);
        }

        return response([
            'message' => 'Empty',
            'data' => null
        ],404);
    }

    public function show($id){
        $order = Order::find($id);

        if(!is_null($order)){
            return response([
                'message' => 'Retrive All Success',
                'data' => $order
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
            'grandtotal' => 'required',
            'address' => 'required',
        ]);
        
        if($validate->fails())
            return response(['message' => $validate->errors(),400]);
        $storeData['no_order'] = Carbon::now().rand(100,10000);
        $storeData['user_id'] = Auth::user()->id;
        $storeData['status'] = "menunggu pembayaran";

        $order = Order::create($storeData);
        if($order){
            $cart = Cart::where('user_id',Auth::user()->id)->get();
            $orderDetailsData = array();
            for($i =0 ; $i < $cart->count(); $i++){
                $orderdetail = array(
                    'order_id' => $order->id,
                    'product_id' => $cart[$i]->product_id,
                    'quantity' => $cart[$i]->quantity,
                    'variance' => $cart[$i]->variance,
                    'subtotal' => $cart[$i]->subtotal,
                    'created_at' => Carbon::now()
                );
                array_push($orderDetailsData,$orderdetail);
            }
            $od = OrderDetail::insert($orderDetailsData);
            Cart::where('user_id',Auth::id())->delete();
            return response([
                'message' => 'Add order Success',
                'data' => $order
            ],200);
        }
        return response([
            'message' => 'Add order Success',
            'data' => $order
        ],200);

    }

    public function destroy($id){
        $order = Order::find($id);
        if(is_null($order)){
            return response([
                'message' => 'order Not Found',
                'data' => null
            ],404);
        }

        if($order->delete()){
            return response([
                'message' => 'Delete order Success',
                'data' => $order
            ],200);
        }

        return response([
            'message' => 'Delete order Failed',
            'data' => null
        ],400);
        
    }

    public function update(Request $request , $id){
        $order = Order::find($id);
        if(is_null($order)){
            return response([
                'message' => 'order Not Found',
                'data' => null
            ],404);
        }
        $updateData =  $request->all();
        $validate =  Validator::make($updateData,[
            'grandtotal' => 'required',
            'status' => 'required',
            'address' => 'required',
        ]);

        if($validate->fails())
            return response(['message' => $validate->errors(),400]);
        
        $order->grandtotal = $updateData['grandtotal'];
        $order->address = $updateData['address'];
        $order->status = $updateData['status'];
        if($order->save()){
            return response([
                'message' => 'Update Order Success',
                'data' => $order
            ],200);
        }

        return response([
            'message' => 'Update Order Failed',
            'data' => null
        ],400);
    }
}
