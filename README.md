# Cat Tinder

Cat Tinder — это увлекательное приложение, которое позволяет вам знакомиться с очаровательными котиками и их породами. Просто свайпайте вправо, чтобы лайкнуть котика, или влево, чтобы пропустить. Приложение ведет подсчет ваших лайков и предоставляет доступ к списку понравившихся котиков, чтобы вы могли вернуться к своим фаворитам в любое время.

Кроме того, вы можете нажать на изображение котика, чтобы перейти на отдельный экран с подробной информацией о его породе, включая описание, темперамент и происхождение.🐾

Реализованные функции
-----

1. Листание карточек:
   - Свайп вправо для лайка (❤️).
   - Свайп влево для дизлайка (❌).

2. Понравившиеся котики (страница доступна при нажатии на сердечко в правом верхнем углу):
   - Возможность сохранять понравившихся котиков.
   - Удаление котиков из избранного.
   - Просмотр описания каждого котика (при нажатии на него)
   - Фильтрация по породам.
 
3. Детальная информация (страница доступна при нажатии на карточку котика):
   - Просмотр полной информации о кошке, включая название породы, описание, темперамент и происхождение.

4. Анимации и визуальные эффекты:
   - Плавные переходы между карточками.
   - Анимации кнопок и эффекты тени.

5. Обработка ошибок:
   - Отображение сообщений об ошибках при проблемах с загрузкой данных.
   - Запасные плейсхолдеры для недоступных изображений.
   - Вы не увидите изображения котиков без их породы.

6. API-интеграция:
   - Использование TheCatAPI для получения данных о котиках.
   - Поддержка кэширования изображений для улучшения производительности.

7. Счетчики лайков и дизлайков:
   - Кнопки работают также, как свайпы.
   - Отображение общего количества лайков и дизлайков.

8. Градиентный фон:
   - Привлекательный градиентный дизайн для фона приложения.

9. Экран загрузки:
   - Реализован экран загрузки, который отображается во время получения данных, обеспечивая плавность пользовательского опыта и предотвращая резкие изменения интерфейса.

10. Использование StatefulWidget:
   - Для страницы понравившихся котиков используется StatefulWidget, что позволяет динамически обновлять список в реальном времени.
   - Реализована анимация появления и удаления котиков, создавая плавный и приятный пользовательский опыт.

11. Использование AlertDialog:
    - При ошибке сети будет отображено, что произошла ошибка.

12. Тестирование:
    - Написаны Unit-тесты на операции лайков и дизлайков.

13. Локальное хранилище:
    - Добавлено локальное хранилище, теперь понравившиеся котики доступны вам всегда.

14. Состояние сети:
    - Добавлен SnackBar, вы будете видеть "Offline mode" всегда, пока у вас нет сети, Online mode - первые 5 секунд после ее появления.
    - Использование connectivity_plus   

15. Приложение работает в оффлайн-режиме:
    - Лайки сохраняются между выходами из приложения.
    - Изображения котиков кэшируются и доступны без сети (использованно cached_network_image).
    - Когда нет сети — это отображается неблокирующим образом в интерфейсе.

Интерфейс
-----

| Основной экран | Детальная информация |
| --- | --- |
| <img src="assets/screenshots/home_screen.jpg" alt="Основной экран" width="300" /> | <img src="assets/screenshots/description_screen.jpg" alt="Детальная информация" width="300" /> |

| Понравившиеся котики | Поиск по понравившимся |
| --- | --- |
| <img src="assets/screenshots/favorite_screen.jpg" alt="Понравившиеся котики" width="300" /> | <img src="assets/screenshots/search.jpg" alt="Поиск" width="300" /> |

| Ошибка сети | Состояние ошибки | Загрузка |
| --- | --- | --- |
| <img src="assets/screenshots/alert.jpg" alt="Ошибка сети" width="300" /> | <img src="assets/screenshots/error_state.jpg" alt="Состояние ошибки" width="300" /> | <img src="assets/screenshots/loading_screen.jpg" alt="Загрузка" width="300" /> |

| Онлайн | Оффлайн | Оффлайн на странице понравившихся |
| --- | --- | --- |
| <img src="assets/screenshots/online_mode.png" alt="Онлайн мод" width="300" /> | <img src="assets/screenshots/offline_mode.png" alt="Оффлайн мод" width="300" /> | <img src="assets/screenshots/offline_mode_liked_screen.png" alt=" Оффлайн на странице понравившихся" width="300" /> |

| Оффлайн после выхода | Оффлайн после выхода на странице понравившихся |
| --- | --- |
| <img src="assets/screenshots/offline_after_exit.png" alt="Оффлайн после выхода" width="300" /> | <img src="assets/screenshots/offline_after_exit_liked_screen.png" alt="Оффлайн после выхода на странице понравившихся" width="300" /> |


Скачать приложение
-----
[📥 Скачать APK](https://github.com/drtcrz23/cattinder/releases/latest/download/app-release.apk)

Технологии
-----
1. Flutter
2. Dart
3. [The Cat Api](https://thecatapi.com/)
4. Управление состояниями: Cubit
5. Dependency injection
6. Декомпозиция на слои: Data, Domain, Presentation.
7. Использование AlertDialog
8. Использование cached_network_image и connectivity_plus 
9. Использование локального хранилища
10. Реализованы Unit-тесты
11. Добавлен SnackBar о состоянии сети
