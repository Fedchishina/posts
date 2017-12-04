<?php
namespace App\Controllers;
/**
 * Class Controller - base controller of project
 */
class Controller
{
    private static $twig;
    protected $countTake = 4;

    public static function initTwig($twig)
    {
        self::$twig = $twig;
    }

    protected function render($template, $params = [])
    {
        echo self::$twig->render($template . ".html.twig", $params);
    }

    protected function pages_array($count)
    {
        $ar = [];

        for ($i = 0; $i < ceil($count / $this->countTake) ; $i ++) {
            $ar[] = $i+1;
        }

        return $ar;
    }

    protected function getSkip($current)
    {
        return ($current - 1) * $this->countTake;
    }
}