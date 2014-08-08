# Icwot [![GemVersion](https://badge.fury.io/rb/icwot.svg)](http://badge.fury.io/rb/icwot)

> Application [Sinatra](http://www.sinatrarb.com)  permettant de logger les notifications envoyées par une application du Web de Objets utilisant l'inversion de contrôle.

## Description
Icwot pour Inversion of Control for Web Of Things est une application Web basée sur le framework [Sinatra](http://www.sinatrarb.com) qui démontre l’inversion de contrôle telle que définie dans le xWoT méta-modèle. C’est à dire qu’un serveur Web est mis en place côté client et est prêt à recevoir des requêtes HTTP POST du service Web auprès duquel il s’est enregistré (Webhook). Icwot a été développé grâce au langage Ruby et est distribué grâce au gestionnaire de bibliothèques Ruby, RubyGems.

## Motivation
La motivation de réaliser un tel module était de démontrer avec quelle facilité il est possible d’implémenter l’inversion de contrôle et de le distribuer. Nous voulons également démontrer qu’il est possible d’implémenter avec facilité une application Web répondant à nos besoins. Si notre implémentation est extrêment basique, c’est par volonté de permettre à n’importe qui de comprendre le code et de là de développer une implémentation plus complète.

## Installation

Dans le terminal exécuter la ligne suivante (nécessite Ruby et RubyGems d'installés):

    $ gem install icwot

## Utilisation
Depuis un terminal lancer la commande

```
$ icwot HOST
```

où `HOST` est l’URL de la ressource d’un service Web de laquelle nous souhaitons recevoir des notifications. Cette commande va :

1. Enregistrer le client par une requête HTTP POST sur l’URL fournie. Dans la requête POST une URL est transmise afin d’indiquer où recevoir des notifications. Par défaut ip-du-client:4567/
2. Lancer le serveur Sinatra avec le port 4567 par défaut. Les notification reçues vont être enregistrées dans le dossier log/icwot/ du répertoire de l’utilisateur.

Par défaut, le header de la requête POST pour s’enregistrer est `accept:application/json ;content_type:application/json`. Il est possible de le changer en ajoutant les arguments ``-c le-content-type et -a le-accept`. Où `le-content-type` et `le-accept` peuvent chacun être soit json soit xml. Donc suivant la valeur de l’argument `le-accept`, le corps de la requête sera encodé de deux manières :
1. En JSON :
```json
{url:xx.xxx.x.x:4567/}
```
2. En XML:
```xml
<client xmlns="http://jaxb.xwot.first.ch.unifr.diuf">
    <uri>xx.xxx.x.x:4567/</uri>
</client>
```

De même que le serveur encode les données en XML si `le-content-type` est égale à `xml`, sinon en JSON.

Il y a également différentes options pour la ligne de commande pouvant être obtenue avec `icwot -h`:

```
Usage : icwot <host>
             -h print help
             -l the host is localhost
             -c the content-type value for the header application/json by default
             -a the accept value for the header text/plain by default
             -p the port where to run the server
             -t the protocol to use http:// by default
             -o where to save the log. By default   your-home-directory/log/icwot-{port}-msg.log
             <host> is the URL of the resource to register for the service.
```

## Structure
Icwot est structuré comme suit : le dossier` bin/` contient le fichier Ruby exécutable `icwot` qui permet de lancer `icwot` depuis le terminal. Le dossier `lib/` contient quatre fichiers nécessaires à l’implémentation :
1. Le fichier `server_client.rb` contenant la classe `ServerClient` responsable de l’implémentation de l'application Web.
2. Le fichier `console.rb` pour l’intéraction avec l’utilisateur.
3. Le fichier `client.rb` pour enregistrer les information du client et les encoder en XML ou JSON.
4. Le fichier `version.rb` pour maintenir un numéro de version de la gem.

## Implémentation
Pour s’enregistrer vers le serveur afin de recevoir des notifications, la gem RestClient est utilisée. Si le code HTTP de la réponse renvoyée par le serveur est 200, nous estimons que l’enregistrement est réussi et nous démarrons le serveur Sinatra.

L’implémentation du serveur Sinatra est extrêmement simple, le code ci-dessous montre le code nécessaire pour que le serveur puisse recevoir une requête HTTP POST à l’URI / et l’enregistre dans un fichier de log.
￼
```ruby
  post ’/’ do
    # response is returned in text/plain
    content_type ’text/plain’
    # save in a special log the body of the received request
    msg.info request.body.read
    # write in main log (the console) that we have received a new   notification
    logger.info "message saved to #{self.class.logger_log_file.path}"
    # return the HTTP code 200 with the text ok
    ’ok’
  end
```

Nous avons défini que toutes les notifications envoyées à l'application sont enresitrées dans un fichier de log. Le format du logger pour enregistrer les notifications est de la forme : `date heure:break message`, où `date` et `heure` sont la date et l’heure à laquelle la notification est reçue, `break` indique un saut à la ligne et `message` est la notification reçue.
Quand l’application reçoit le signal `EXIT`, elle envoie une requête au serveur pour se désenregistrer de l’envoi de notifications et arrête le serveur Sinatra.
