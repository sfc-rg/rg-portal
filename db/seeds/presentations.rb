Presentation.delete_all

contents = %w(OS コンパイラ 決済システム 自然言語処理システム SNSクライアント .vimrc ネットワークトポロジー IoTデバイス 動画配信サービス バージョン管理システム XSS)
comments = %w(素晴らしいプレゼンだった:+1: 最後の方が少し難しかった:cry: よくあんな量のスライドを作った:scream: 評価の仕方に問題がありそうなので、もう少し考える必要がある。 ぜひこのまま頑張ってほしい)

meetings = Meeting.all
users = User.all
meetings.each_with_index do |meeting, i|
  if i % 2 == 0
    Presentation.create!(
      user: User.first,
      meeting: meeting,
      title: "#{contents.sample}講座"
    )
  end

  contents.sample(rand(3)).each do |content|
    presentation = Presentation.create!(
      user: users.sample,
      meeting: meetings.sample,
      title: "ぼくのかんがえた さいきょうの #{content}"
    )

    comments.sample(rand(3)).each do |comment|
      presentation.comments.build(
        user: users.sample,
        content: comment
      ).save!
    end
  end
end
