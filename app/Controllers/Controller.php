<?php
namespace App\Controllers;
/**
 * Class Controller - base controller of project
 */
class Controller
{
    private static $twig;

    //count of elements (for pagination)
    protected $countTake = 4;

    public static function initTwig($twig)
    {
        self::$twig = $twig;
    }

    protected function render($template, $params = [])
    {
        echo self::$twig->render($template . ".html.twig", $params);
    }

    /*
     * getting array of num pages (for pagination)
     */
    protected function pages_array($count)
    {
        $ar = [];

        for ($i = 0; $i < ceil($count / $this->countTake) ; $i ++) {
            $ar[] = $i+1;
        }

        return $ar;
    }

    /*
     * get count skip of pages (for pagination)
     */
    protected function getSkip($current)
    {
        return ($current - 1) * $this->countTake;
    }
}