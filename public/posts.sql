-- phpMyAdmin SQL Dump
-- version 4.4.15.7
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1:3306
-- Время создания: Дек 06 2017 г., 09:47
-- Версия сервера: 5.7.13
-- Версия PHP: 7.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `posts`
--

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) unsigned NOT NULL COMMENT 'первичный ключ',
  `name` varchar(240) NOT NULL COMMENT 'название категории',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'дата создания',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'дата последнего изменения'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='категории постов';

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'спорт', NULL, NULL),
(2, 'кулинария', NULL, NULL),
(3, 'туризм', NULL, NULL),
(4, 'развлечения', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `posts`
--

CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(11) NOT NULL COMMENT 'первичный ключ',
  `name` varchar(240) NOT NULL COMMENT 'название поста',
  `description` varchar(240) NOT NULL COMMENT 'описание поста',
  `content` text NOT NULL COMMENT 'контент поста',
  `category_id` int(11) unsigned NOT NULL COMMENT 'категория, к которой относится пост',
  `user_id` int(11) unsigned NOT NULL COMMENT 'пользователь, создавший пост',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'дата создания',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'дата последнего изменения'
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='посты';

--
-- Дамп данных таблицы `posts`
--

INSERT INTO `posts` (`id`, `name`, `description`, `content`, `category_id`, `user_id`, `created_at`, `updated_at`) VALUES
(16, ' Чемпионат мира по футболу 2018', ' 21-й чемпионат мира по футболу ФИФА, финальная часть которого пройдёт в России с 14 июня по 15 июля 2018 года', '<p>Россия в первый раз в своей истории станет страной-хозяйкой мирового чемпионата по футболу</p>\r\n', 1, 5, '2017-12-06 06:30:38', '2017-12-06 06:30:38'),
(17, 'блюда на Новый год', 'список оригинальных блюд', '<ul>\r\n	<li>канапе с семгой</li>\r\n	<li>свекольный чизкейк с форелью</li>\r\n	<li>салат &quot;новогодние шишки&quot;</li>\r\n</ul>\r\n', 2, 5, '2017-12-06 06:37:09', '2017-12-06 06:37:09'),
(18, 'правильное питание', 'формула успеха!', '<p>Для спортсменов</p>\r\n\r\n<p>2 г. белка на 1 кг веса</p>\r\n\r\n<p>1 г. жира на 1 кг веса</p>\r\n\r\n<p>4 г. белка на 1 кг веса</p>\r\n', 2, 5, '2017-12-06 06:39:37', '2017-12-06 06:39:37'),
(19, '  Санкт-Петербург', 'лучший город на земле', '<p>Санкт-Петербург расположен на северо-западе Российской Федерации, на побережье Финского залива</p>\n', 3, 5, '2017-12-06 06:42:00', '2017-12-06 06:42:00'),
(20, 'Москва', 'крупнейший мегаполис России', '<p><img alt="" src="https://www.tourprom.ru/site_media/images/upload/2016/8/30/resortimage/moskva-kremlj.jpg" style="height:200px; width:500px" /></p>\r\n', 3, 5, '2017-12-06 06:44:12', '2017-12-06 06:44:12');

-- --------------------------------------------------------

--
-- Структура таблицы `posts_likes`
--

CREATE TABLE IF NOT EXISTS `posts_likes` (
  `id` int(11) NOT NULL COMMENT 'первичный ключ',
  `post_id` int(10) unsigned NOT NULL COMMENT 'ключ поста',
  `user_id` int(10) unsigned NOT NULL COMMENT 'ключ пользователя, поставившего лайк',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'дата создания',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'дата последнего изменения'
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='лайки постов';

--
-- Дамп данных таблицы `posts_likes`
--

INSERT INTO `posts_likes` (`id`, `post_id`, `user_id`, `created_at`, `updated_at`) VALUES
(10, 13, 1, '2017-12-05 09:44:23', '2017-12-05 09:44:23'),
(13, 17, 5, '2017-12-06 06:37:16', '2017-12-06 06:37:16'),
(14, 19, 5, '2017-12-06 06:42:37', '2017-12-06 06:42:37'),
(15, 18, 5, '2017-12-06 06:46:31', '2017-12-06 06:46:31'),
(16, 19, 6, '2017-12-06 06:47:03', '2017-12-06 06:47:03'),
(17, 18, 6, '2017-12-06 06:47:06', '2017-12-06 06:47:06');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL COMMENT 'первичный ключ ',
  `name` varchar(240) NOT NULL COMMENT 'имя пользователя',
  `password` varchar(240) NOT NULL COMMENT 'пароль пользователя',
  `email` varchar(240) NOT NULL COMMENT 'email пользователя',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'дата создания',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'дата последнего изменения'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='пользователи сайта';

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `password`, `email`, `created_at`, `updated_at`) VALUES
(5, 'Королев Сергей', 'e10adc3949ba59abbe56e057f20f883e', 'user@user.ru', '2017-12-06 06:28:41', '2017-12-06 06:28:41'),
(6, ' Симонова Татьяна', 'e10adc3949ba59abbe56e057f20f883e', 'user123@user.ru', '2017-12-06 06:46:57', '2017-12-06 06:46:57');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `posts_likes`
--
ALTER TABLE `posts_likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'первичный ключ',AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT для таблицы `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'первичный ключ',AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT для таблицы `posts_likes`
--
ALTER TABLE `posts_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'первичный ключ',AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'первичный ключ ',AUTO_INCREMENT=7;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
