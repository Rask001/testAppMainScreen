
Главный экран приложения по заказу еды  
При нажатии на категорию происходит скролл таблицы именно к данной категории  
Запрос картинки происходит один раз, благодаря чему таблица не тормозит, так как изображения храняться в кэше  
При скролле таблицы вверх скрываеться хедер с акциями, при этом категории прилипают к навигейшину  


**технологии:**
1. Адаптивная верстка кодом с использованием NSLayoutConstraint & Anchors
2. Архитектура MVP + MVC(в ветке Developing)
3. NSCache
4. CoreAnimation
5. JSON
6. URLSession

 #Код в процессе рефакторинга
![  dd ](https://user-images.githubusercontent.com/97259692/196940025-bce371ae-688c-47ac-bafd-3a0ef1903557.png)
