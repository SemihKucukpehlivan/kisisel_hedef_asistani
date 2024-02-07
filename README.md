# kisisel_hedef_asistani

Personal Goal Assistant was developed using the Flutter framework and written in the Dart programming language. Firebase live database was used as the database. VSCode was used to compile the project and tests were performed on both a live Android device and Android Studio Virtual Device.

<img src="https://github.com/SemihKucukpehlivan/kisisel_hedef_asistani/assets/94116102/288272df-833f-44e1-a48d-d401c6cbf987" alt="Login Page Metin" width="300" height="700">

<img src="https://github.com/SemihKucukpehlivan/kisisel_hedef_asistani/assets/94116102/6044080f-9c90-4e77-9069-92e92f69a5db" alt="signUp" width="300" height="700">

During the login phase of the application, Firebase Authentication was used for the authentication process. In order to log in to the application, users first want to log in with a combination of e-mail and password. After entering this information, the verification process is carried out by Firebase Authentication.
In the second option, users can also log in to the application through their Google accounts. They can access the application quickly and securely by using the verification information of their Google accounts.
Additionally, as seen in the picture below, Firebase Authentication shows us which verification method the logged-in users use, thanks to the Firebase Console.

<img src="https://github.com/SemihKucukpehlivan/kisisel_hedef_asistani/assets/94116102/062d957e-f01f-4a99-9525-5e236b37ce7d" alt="menu" width="300" height="700">

Uygulamamızın ana menusu olan “Menu Screen” dört farklı Card Butondan oluşmaktadır. Ayrıca ekranın sağ üst köşesinde bir tane Logout butonu bulunmaktadır. Bu buton bizi hem giriş ekranına geri götürür aynı zamanda firebase’den güvenli çıkış yapmamızı sağlar.
 İlk kartta Pedometer yani adım sayar yer almaktadır günde ne kadar adım attığımızı gösteren bu sayfa aynı zamanda adım sayılarımızı sıfırlamayı da sağlıyor.
İkinci kartımızda ise To Do kartımız vardır. Günlük aylık hatta yıllık işlerimizi yapacaklarımızı kaydedebileceğimiz bir yapılacaklar listesi yer almaktadır.
Üçüncü kartımızda ise Stopwatch yani bir tür sayacımız yer almaktadır. Bu sayaç sayesinde günlük egzersiz sürelerimiz takip edebilir firebase firestore’a kaydedebiliriz.
Dördüncü ve son kartımız grafiklerimizin bulunduğu sayfadır. Bu sayfa da attığımız günlük adım sayılarımızı görebildiğimiz gibi aynı zamanda günlük ne kadar egzersiz yaptığımızı gösteren 2 tane grafik bulunmaktadır.


<img src="https://github.com/SemihKucukpehlivan/kisisel_hedef_asistani/assets/94116102/e38cfa9b-79a6-427e-8d3f-f74a848b3f0d" alt="pedometer" width="300" height="700">

<img src="https://github.com/SemihKucukpehlivan/kisisel_hedef_asistani/assets/94116102/fced7314-698f-4ee5-b46b-1a00b352752f" alt="stopwatch" width="300" height="700">

<img src="https://github.com/SemihKucukpehlivan/kisisel_hedef_asistani/assets/94116102/d7af7c93-1905-4ba8-8080-c10f50d1a77e" alt="todoList" width="300" height="700">

<img src="https://github.com/SemihKucukpehlivan/kisisel_hedef_asistani/assets/94116102/e4e15a72-2b38-4c37-9ace-67d6639215da" alt="createTodo" width="300" height="700">
