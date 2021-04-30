<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Campsite extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'telephone',
        'address',
        'description',
    ];


    protected $hidden = [
        'created_at',
        'updated_at',
    ];

}
