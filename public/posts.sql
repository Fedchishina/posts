-- phpMyAdmin SQL Dump
-- version 4.4.15.7
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1:3306
-- Время создания: Дек 03 2017 г., 21:13
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
  `name` varchar(255) NOT NULL COMMENT 'название категории',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'дата создания',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'дата последнего изменения'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='категории постов';

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'спорт', NULL, NULL),
(2, 'кулинария', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `posts`
--

CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(11) NOT NULL COMMENT 'первичный ключ',
  `name` varchar(255) NOT NULL COMMENT 'название поста',
  `description` varchar(255) NOT NULL COMMENT 'описание поста',
  `content` text NOT NULL COMMENT 'контент поста',
  `category_id` int(11) unsigned NOT NULL COMMENT 'категория, к которой относится пост',
  `user_id` int(11) unsigned NOT NULL COMMENT 'пользователь, создавший пост',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'дата создания',
  `update_at` timestamp NULL DEFAULT NULL COMMENT 'дата последнего изменения'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='посты';

--
-- Дамп данных таблицы `posts`
--

INSERT INTO `posts` (`id`, `name`, `description`, `content`, `category_id`, `user_id`, `created_at`, `update_at`) VALUES
(1, 'о спорте', 'ываываывсывмым', 'выывавыавыаыва', 1, 1, NULL, NULL),
(2, 'кухня', 'кухня', 'кухня', 2, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL COMMENT 'первичный ключ ',
  `name` varchar(255) NOT NULL COMMENT 'имя пользователя',
  `password` varchar(255) NOT NULL COMMENT 'пароль пользователя',
  `email` varchar(255) NOT NULL COMMENT 'email пользователя',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'дата создания',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'дата последнего изменения'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='пользователи сайта';

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `password`, `email`, `created_at`, `updated_at`) VALUES
(1, 'user', 'e10adc3949ba59abbe56e057f20f883e', 'user@user.ru', '2017-12-03 12:31:32', '2017-12-03 12:31:32'),
(2, ' 123', 'e10adc3949ba59abbe56e057f20f883e', 'user1@user.ru', '2017-12-03 13:04:02', '2017-12-03 13:04:02'),
(3, 'user555', 'e10adc3949ba59abbe56e057f20f883e', 'user555@user.ru', '2017-12-03 13:05:01', '2017-12-03 13:05:01'),
(4, '123ddd', 'e10adc3949ba59abbe56e057f20f883e', 'usedddr@user.ru', '2017-12-03 15:58:09', '2017-12-03 15:58:09');

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
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'первичный ключ',AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'первичный ключ',AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'первичный ключ ',AUTO_INCREMENT=5;
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
