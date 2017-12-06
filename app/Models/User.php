<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class User extends Model
{
    protected $table = 'users';

    protected $fillable = [
        'name',
        'email',
        'password'
    ];

    //----------------  validation functions  -----------------------//
    public static function checkName($name)
    {
        $length = strlen(trim($name));
        if(($length >= 2)&&( $length <= 240)) {
            return true;
        } else {
            return false;
        }
    }

    public static function checkEmail($email)
    {
        if(filter_var($email, FILTER_VALIDATE_EMAIL)) {
            return true;
        } else {
            return false;
        }
    }

    public static function checkUniqueEmail($email)
    {
        $count = User::where('email', $email)->count();
        if($count == 0) {
            return true;
        } else {
            return false;
        }
    }

    public static function checkPassword($email)
    {
        if(strlen(trim($email)) >= 6) {
            return true;
        } else {
            return false;
        }
    }

    public static function validate($params, $isCreate = true) {
        $errors = [];
        if (!User::checkEmail($params['email'])){
            $errors['email'][] = 'некорректный email';
        }
        if (!User::checkPassword($params['password'])){
            $errors['password'][] = 'пароль должен содержать не меньше 6 символов';
        }
        if($isCreate) {
            if (!User::checkName($params['name'])){
                $errors['name'][] = 'имя должно содержать не меньше 2 символов и не больше 240. Сейчас введено ' . strlen($params['name']);
            }
            if (!User::checkUniqueEmail($params['email'])){
                $errors['email'][] = 'данный email уже зарегистрирован в системе';
            }
        }

        return $errors;
    }
    //-----------------------------------------------------------------------
}