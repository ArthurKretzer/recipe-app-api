Recipe API project

Project created following the course Build a Backend REST API with Python & Django - Advanced (https://www.udemy.com/course/django-python-advanced/)

This project will create an API to access food recipes stored in databases.

My interest is to develop backend knowledge using Django, to exercise usage of containers in CI/CD environemns and also to exercise test driven development.

Linting

docker-compose run —rm app sh -c “flake8”

Testing

docker-compose run —rm app sh -c “python manage.py manage.py test”

Running

docker-compose up
