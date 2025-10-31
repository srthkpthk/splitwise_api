# Project Overview

## Purpose
This is a Dart package (`splitwise_api`) that provides a wrapper for the Splitwise API v3.0. It's published on pub.dev and allows Dart/Flutter developers to integrate Splitwise functionality into their applications.

## Tech Stack
- **Language**: Dart (SDK >=2.12.0 <3.0.0, null-safe)
- **Current Dart Version**: 3.6.2 (stable)
- **Authentication**: OAuth 1.0 with HMAC-SHA1 signatures
- **Key Dependencies**:
  - `oauth1: ^2.0.0` - OAuth 1.0 authentication
  - `json_serializable: ^5.0.2` - JSON serialization support
  - `json_annotation: ^4.1.0` - JSON annotation support
- **Dev Dependencies**:
  - `build_runner: ^2.1.2` - Code generation

## Package Type
This is a library package (not an application), designed to be used as a dependency in other Dart/Flutter projects.

## API Base URL
All requests go to: `https://secure.splitwise.com/api/v3.0/`

## Current Version
2.0.3
