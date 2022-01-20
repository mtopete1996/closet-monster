module DatetimeSupport
  def where_timestamp_date(column, date)
    where("#{column}::date = ?", date)
  end
end
