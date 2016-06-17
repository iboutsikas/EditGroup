class Admin::DashboardController < ApplicationController
  layout 'dashboard'

  before_filter :authenticate_member!
  before_filter do
    redirect_to root_path unless current_member && current_member.isAdmin?
  end

  def preferences
    respond_to do |format|
      format.html
    end
  end

  ###
  #  Charts
  ###
  def data_chart
    @members = Member.all
    load_proj_charts
    load_pubs_per_year
    load_pub_charts
    globalChartOptions
  end

  def site_chart
    @visits = Visit.all
    unless @visits.empty?
      @visits = @visits.sort_by do |v|
        v[:started_at]
      end
      @visit_sum = @visits.count
      #daily_visits = @visits.group_by{|dv| dv.started_at.day}
      load_browser_pie
      load_visits_line
      load_os_pie
      globalChartOptions
    end
  end

  private


  def load_os_pie
    os = @visits.group_by{|vb| vb.os}

    data = []

    os.each do |o, v|
      os_percentage = []
      os_percentage << o
      os_percentage << v.count * 100 / @visit_sum.to_f
      os_percentage[1] = os_percentage[1].round(2)
      data << os_percentage
    end

    @os_pie = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart({:defaultSeriesType=>"pie" , :margin=> [30, 30, 30, 30]} )
      series = {
          :innerSize=> '50%',
          :type=> 'pie',
          :name=> 'Operating Systems share',
          :data=> data
      }

      f.series(series)
      f.options[:title][:text] = "Visitor OS Share"
      f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'})
      f.plot_options(:pie=>{
        :allowPointSelect=>true,
        :cursor=>"pointer" ,
        :startAngle=> '-90',
        :endAngle=> '90',
                :center=> ['50%', '75%'],
        :dataLabels=>{
          :enabled=>true,
          :color=>"black",
          :style=>{
            :font=>"13px Trebuchet MS, Verdana, sans-serif"
          }
        }
      })
    end

  end

  def load_visits_line
    #Setup Data
    vis = []
    @days = []
    daysprsd = []
    daily_visits = @visits.group_by{|dv| dv.started_at.to_date}
    today = Date.today.to_date

    for i in 0..30
      @days << (today-i)
    end
    @days = @days.sort

    @days.each do |d|
      daysprsd << d.strftime('%d/%b')
      unless daily_visits[d].nil?
        vis << daily_visits[d].count
      else
        vis << 0
      end
    end



    #Create Chart
    @visits_line_month = LazyHighCharts::HighChart.new('chart') do |f|
      f.title(text: "Daily Visits")
      f.subtitle(text: "Last 30 days")
      f.xAxis(categories: daysprsd)
      f.series(name: "Visits", yAxis: 0, data: vis)

      f.yAxis [
        title: {text: "Visits", margin: 20}
      ]
      f.chart({defaultSeriesType: "spline"})
    end
  end

  def load_browser_pie
    data = []
    browsers = @visits.group_by{|vb| vb.browser}


    browsers.each do |b, v|
      browser_percentage = []
      browser_percentage << b
      browser_percentage << v.count * 100 / @visit_sum.to_f
      browser_percentage[1] = browser_percentage[1].round(2)
      data << browser_percentage
    end

    @browser_pie = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart({:defaultSeriesType=>"pie" , :margin=> [30, 30, 30, 30]} )
      series = {
          :type=> 'pie',
          :name=> 'Browser share',
          :data=> data
      }
      f.series(series)
      f.options[:title][:text] = "Visitor Browser Share"
      f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'})
      f.plot_options(:pie=>{
        :allowPointSelect=>true,
        :cursor=>"pointer" ,
        :dataLabels=>{
          :enabled=>true,
          :color=>"black",
          :style=>{
            :font=>"13px Trebuchet MS, Verdana, sans-serif"
          }
        }
      })
    end
  end

  def load_pub_charts
    #Set up Data
    member_journals = []
    member_in_publ = []
    mem_conf = []

    @members.each do |mem|
      if (mem.participant != nil)
        m = mem.person.participant.title+" "+ mem.lastName+" "+ mem.firstName[0].upcase+"."
        numj = mem.journals.size
        numc = mem.conferences.size
        if(numc> 0 || numj > 0 )
          member_in_publ << m
          mem_conf << numc
          member_journals << numj
        end
      end
    end

    #Create Chart
    @pub_chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Publications per Member")
      f.xAxis(categories: member_in_publ)
      f.series(name: "Journals", yAxis: 0, data: member_journals)
      f.series(name: "Conf. Publications", yAxis: 1, data: mem_conf)

      f.yAxis [
        {title: {text: "Journals", margin: 20} },
        {title: {text: "Conf. Publications"}, opposite: true},
      ]
      f.chart({defaultSeriesType: "column"})
    end
  end

  def load_proj_charts
    #Initialize data
    member_projects = []
    member_in_projects = []

     @members.each do |mem|
      if (mem.participant != nil)
        m = mem.person.participant.title+" "+ mem.lastName+" "+ mem.firstName[0].upcase+"."
        numpr = mem.projects.size
        if(numpr > 0)
          member_in_projects << m
          member_projects << numpr
        end
      end
    end

    #Create Chart
    @proj_chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Projects per Member")
      f.xAxis(categories: member_in_projects)
      f.series(name: "Projects", yAxis: 0, data:  member_projects)
      f.yAxis [
        {title: {text: "# of Projects", margin: 20} },
      ]
      f.chart({defaultSeriesType: "column"})
    end
  end


  def load_pubs_per_year
    #Setup data
    years = []
    conferences_in_year = []
    journals_in_year = []
    journals = Journal.all.group_by{|yj| yj.publication.date.year}
    years = years | journals.keys
    conferences = Conference.all.group_by{|yc| yc.publication.date.year}
    years = years | conferences.keys
    years = years.sort
    years.each do |y|
      unless conferences[y].nil?
        conferences_in_year << conferences[y].count
      end
      unless journals[y].nil?
        journals_in_year << journals[y].count
      end
    end

    #Create chart
    @data_per_year_chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Publications per Year")
      f.xAxis(categories: years)
      f.series(name: "Journals", yAxis: 0, data: journals_in_year)
      f.series(name: "Conference Publications", yAxis: 0, data: conferences_in_year)
      f.yAxis[
        min: 0,
        stackLabels: {
          enabled: true,
          style: {
            fontWeight: 'bold'
          }
        }
      ]
      f.plotOptions({:column => {stacking: 'normal',
          dataLabels: {
                    enabled: true,
                    style: {
                        textShadow: '0 0 3px black'
                    }
          }
        }
      })
      f.legend(align: 'right',
            x: -30,
            verticalAlign: 'top',
            y: 15,
            floating: true,
            borderColor: '#CCC',
            borderWidth: 1,
            shadow: false)
      f.chart({defaultSeriesType: "column"})
    end
  end


  def globalChartOptions
    @chart_globals = LazyHighCharts::HighChartGlobals.new do |f|
      f.global(useUTC: false)
      f.chart(
        backgroundColor: "rgba(225, 225, 225, .9)",
        borderWidth: 1,
        plotBackgroundColor: "rgba(205, 205, 205, .9)",
        plotShadow: false,
        plotBorderWidth: 1
      )
      f.lang(thousandsSep: ".")
      f.colors(["#FF6C12", "#12FFFF", "#89FF12", "#C4FF12", "#12FF88"])
    end
  end

end
