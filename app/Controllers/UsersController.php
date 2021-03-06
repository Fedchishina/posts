<?php

namespace App\Controllers;

use App\Models\User;
class UsersController extends Controller
{
    /**
     * GET - viewing login form
     * POST - login user
     */
    public function actionLogin()
    {
        if ($_SERVER['REQUEST_METHOD'] == 'GET') {
            $this->render('pages/login');
        } else {
            $validateErrors = User::validate($_POST, false);
            if (count($validateErrors) == 0){
                $user = User::where('email', $_POST['email'])->where('password', md5($_POST['password']))->first();
                if ($user) {
                    $_SESSION['auth'] = 'true';
                    $_SESSION['user_id'] = $user->id;
                    $_SESSION['user_name'] = $user->name;
                    header("Location: /");
                } else {
                    $validateErrors['password'][] = 'неверный email или пароль';
                    $this->render('pages/login', ['errors' => $validateErrors, 'inputs' => $_POST]);
                }
            } else {
                $this->render('pages/login', ['errors' => $validateErrors, 'inputs' => $_POST]);
            }
        }
    }

    /**
     * logout of user
     */
    public function actionLogout()
    {
        unset($_SESSION['auth']);
        unset($_SESSION['user_id']);
        unset($_SESSION['user_name']);
        header("Location: /");
    }

    /**
     * GET - viewing register form
     * POST - register user
     */
    public function actionRegister()
    {
        if ($_SERVER['REQUEST_METHOD'] == 'GET') {
            $this->render('pages/register');
        } else {
            $validateErrors = User::validate($_POST);
            if (count($validateErrors) == 0){
                $user = User::create([
                    'name' => $_POST['name'],
                    'password' => md5($_POST['password']),
                    'email' => $_POST['email'],
                ]);
                $_SESSION['auth'] = 'true';
                $_SESSION['user_id'] = $user->id;
                $_SESSION['user_name'] = $user->name;
                header("Location: /");
            } else {
                $this->render('pages/register', ['errors' => $validateErrors, 'inputs' => $_POST]);
            }
        }
    }
}