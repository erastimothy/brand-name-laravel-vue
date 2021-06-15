<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use TCG\Voyager\Traits\Translatable;

class Category extends Model
{
    use Translatable;

    protected $translatable = ['slug', 'name'];

    protected $table = 'categories';

    protected $fillable = ['name','slug','icon','image'];

    public function products(){
        return $this->hasMany(Product::class);
    }

    public function parentId()
    {
        return $this->belongsTo(self::class);
    }
}
