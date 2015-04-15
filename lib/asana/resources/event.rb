### WARNING: This file is auto-generated by the asana-api-meta repo. Do not
### edit it manually.

module Asana
  module Resources
    # An _event_ is an object representing a change to a resource that was observed
    # by an event subscription.
    #
    # In general, requesting events on a resource is faster and subject to higher
    # rate limits than requesting the resource itself. Additionally, change events
    # bubble up - listening to events on a project would include when stories are
    # added to tasks in the project, even on subtasks.
    #
    # Establish an initial sync token by making a request with no sync token.
    # The response will be a `412` error - the same as if the sync token had
    # expired.
    #
    # Subsequent requests should always provide the sync token from the immediately
    # preceding call.
    #
    # Sync tokens may not be valid if you attempt to go 'backward' in the history
    # by requesting previous tokens, though re-requesting the current sync token
    # is generally safe, and will always return the same results.
    #
    # When you receive a `412 Precondition Failed` error, it means that the
    # sync token is either invalid or expired. If you are attempting to keep a set
    # of data in sync, this signals you may need to re-crawl the data.
    #
    # Sync tokens always expire after 24 hours, but may expire sooner, depending on
    # load on the service.
    class Event < Resource

      attr_reader :type

      class << self
        # Returns the plural name of the resource.
        def plural_name
          'events'
        end

        # Returns the full record for all events that have occurred since the
        # sync token was created.
        #
        # resource - [Id] A resource ID to subscribe to. The resource can be a task or project.
        #
        # sync - [String] A sync token received from the last request, or none on first sync.
        # Events will be returned from the point in time that the sync token
        # was generated.
        #
        # Notes:
        #
        # On your first request, omit the sync token. The response will be the
        # same as for an expired sync token, and will include a new valid
        # sync token.
        #
        # If the sync token is too old (which may happen from time to time)
        # the API will return a `412 Precondition Failed` error, and include
        # a fresh `sync` token in the response.
        def get(client, resource:, sync: nil)
          params = { resource: resource, sync: sync }.reject { |_,v| v.nil? }
          Collection.new(body(client.get("/events", params: params)).map { |data| self.new(data, client: client) }, client: client)
        end
      end

    end
  end
end
