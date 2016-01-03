# The method opStatus from the Latch Gem is not properly working (missing /op/ on the url)
# Its override on this class

class LatchSdk < Latch

  def opStatus(accountId, operationId)
    http_get_proxy(API_CHECK_STATUS_URL + "/" + accountId + '/op/' + operationId)
  end

end