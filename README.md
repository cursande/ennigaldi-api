# Ennigaldi

This Hanami application will suck up article data from Museum Victoria (for now this is the only public API being utilised).

Key article data is stored in the database, while image processing involves uploading to S3, or storing in-memory during testing.
This data is then consumable via a GraphQL endpoint.

https://collections.museumvictoria.com.au/developers
