# Brewery
> Aplicación sobre la información de cervezas para prueba de código.

[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/EZSwiftExtensions.svg)](https://img.shields.io/cocoapods/v/LFAlertController.svg)  
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)

## Features

- [x] Obtener una lista de estilos de cerveza y listarlas, al pulsar sobre una de estas categorías se accederá a una vista tipo grid.
- [x] La vista tipo grid (UICollectionView) contendrá las cervezas del estilo seleccionado seleccionada en el paso anterior. Este grid tendrá un estilo muy similar al que encontrarás en las pantallas de categoría de Lola Market (mínimo de 3 items por fila). Cada item al menos debe contener el nombre de la cerveza y su imagen.
- [x] Al pulsar sobre uno de los items abrir una vista detalle que muestre de forma similar a los detalles de producto de Lola Market la información de la cerveza. Al menos contendrá la foto, el nombre de la cerveza y una descripción, pero puedes añadir el resto de información interesante que consideres.
- [x] La aplicación permitirá guardar algunas cervezas como favoritas y estas deben destacar de alguna manera frente a las demás.
- [x] La aplicación permitirá hacer zoom sobre la imagen de una cerveza en la pantalla detalle.

## Requirements

- iOS 11.0+
- Xcode 10.0

## Installation

#### Manual
Puedes bajarte el repositorio en formato zip, descomprimirlo y lanzar el Workspace

#### Xcode
Puedes clonar desde el Xcode el repositorio. 

## Architecture

Se ha usado una arquitectura MVVM-C. El motivo elegido para elegir esta arquitectura ha sido por su fácil desacomplamiento y posibilidad de realizar test de todos sus componentes, además se ha usado los Coordinators para enrutar la distintas transicciones de la aplicación.

## Library

'Kingfisher', '~> 4.0'
'Moya', '~> 11.0'
'SwiftyJSON', '~> 4.0'

## Tests

No se ha realizado todos los tests posibles de la aplicación y no se ha llegado al 100% en muchas de las clases, pero se puede ver un ejemplo bastante claro dónde se hacen test en gran parte de los componentes de la arquitectura en la clase 'BeerListTests.swift'

## Contribute

We would love you for the contribution to **YourLibraryName**, check the ``LICENSE`` file for more info.

## Meta

Your Name – [@YourTwitter](https://twitter.com/dbader_org) – YourEmail@example.com

Distributed under the XYZ license. See ``LICENSE`` for more information.

[https://github.com/yourname/github-link](https://github.com/dbader/)

[swift-image]:https://img.shields.io/badge/swift-4.2-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com

