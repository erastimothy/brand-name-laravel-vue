<?php

namespace App;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class Order extends Model
{
    protected $fillable = ['no_order','grandtotal','user_id','status','address'];

    public function user() {
        return $this->belongsTo(User::class);
    }

    public function orderDetails(){
        return $this->hasMany(OrderDetail::class);
    }

    public function confirmPayment(){
        return $this->hasOne(ConfirmPayment::class);
    }

    public function createdAtInMyFormat()
    {
       return $this->created_at->format('F j, Y @ g:i A');
    }
}
