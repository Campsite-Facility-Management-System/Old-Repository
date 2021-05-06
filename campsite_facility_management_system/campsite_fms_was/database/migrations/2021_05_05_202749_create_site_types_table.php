<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSiteTypesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('site_types', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('campsite_id');
            $table->string('name');
            $table->string('description');
            $table->integer('price');
            $table->integer('max_car_num');
            $table->integer('max_adult_num');
            $table->integer('max_children_num');
            $table->integer('max_energy');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('site_types');
    }
}
