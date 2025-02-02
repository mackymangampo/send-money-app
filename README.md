# send_money_application

A new Flutter project.

## API Service Application

This application provides a set of services to interact with a mock API for login, logout, balance retrieval, sending money, and fetching transaction history.

## Prerequisites

- Dart SDK: Ensure you have Dart installed on your machine. You can download it from [dart.dev](https://dart.dev/get-dart).

## Getting Started

This project is a starting point for a Flutter application.

1. **Clone the Repository**

   Clone this repository to your local machine using:

   ```bash
   git clone https://github.com/mackymangampo/send-money-app.git
   ```

2. **Navigate to the Project Directory**

   Change into the project directory:

   ```bash
   cd local-machine-name/send-money-app
   ```

3. **Install Dependencies**

   Run the following command to install the necessary dependencies:

   ```bash
   flutter clean & flutter pub get
   ```

## Running Unit Tests

This project uses the `test` package for unit testing. To run the tests, follow these steps:

1. **Ensure the `mockito` and `build_runner` package is included in your `pubspec.yaml` file:**

   ```yaml
   dev_dependencies:
     build_runner: ^2.4.6
     mockito: ^5.0.0
   ```

2. **Run the Tests**

   Execute the following command to run all tests:

   ```bash
   flutter test test/providers
   ```

   This will run all test files located in the `test` directory.

## Project Structure

- `lib/`: Contains the main source code for the application.
- `test/`: Contains the unit tests for the application.
