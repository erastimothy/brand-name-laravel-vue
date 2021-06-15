
# BRAND NAME (Laravel)

This branch for back-end apps (laravel)

## Run Locally

Clone the project

```bash
  git clone https://github.com/erastimothy/brand-name-laravel-vue-.git -b back-end --single-branch api
```

Go to the project directory

```bash
  cd api
```

Install dependencies

```bash
  composer install
  cp .env.example .env
  php artisan key:generate
  php artisan cache:clear
  php artisan migrate
  php artisan voyager:install
  php artisan passport:install
  php artisan storage:link
  
```

Start the server

```bash
  php artisan serve
```

Login Account
```bash
  email    : admin@admin.com
  password : password
```

  
## SMTP

To run this project, you will need to edit the smtp mail in .env

https://medium.com/@agavitalis/how-to-send-an-email-in-laravel-using-gmail-smtp-server-53d962f01a0c

  
## Demo

Check this video below, for demo of this project

[User UI](https://youtu.be/H012szjIgpo)

[Admin UI](https://youtu.be/5HtiTydy6LM)


  
## Authors

- [Eras Timothy](https://www.github.com/erastimothy)

  
