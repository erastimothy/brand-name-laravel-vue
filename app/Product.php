<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $fillable = ['name','description','image','category_id','price','stock'];

    public function category(){
        return $this->belongsTo(Category::class);
    }

    public function carts(){
        return $this->hasMany(Cart::class);
    }

    public function orderDetails(){
        return $this->hasMany(OrderDetail::class);
    }
}
