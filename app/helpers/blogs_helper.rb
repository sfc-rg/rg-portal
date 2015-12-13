module BlogsHelper
  def displayable_datetime(time)
    time.strftime('%Y/%m/%d %H:%M:%S')
  end
end
